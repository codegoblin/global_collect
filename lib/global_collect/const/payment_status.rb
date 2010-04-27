module GlobalCollect::Const
  module PaymentStatus
    def self.from_code(code)
      code = code.to_i
      raise ArgumentError.new("Invalid payment status code!") unless STATUSES.key?(code)
      Status.new(code, *STATUSES[code])
    end
    
    def self.from_name(name)
      code, strings = STATUSES.detect{|k,v| v.first == name }
      status(code) if code
    end

    private

    STATUSES = {
      0     => ["CREATED"                                                                 , "The payment attempt was created."                                                                                                                                                                                                ],
      20    => ["PENDING AT MERCHANT"                                                     , "The Hosted Merchant Link transaction is waiting for the consumer to be redirected by the merchant to WebCollect."                                                                                                                ],
      25    => ["PENDING AT GLOBALCOLLECT"                                                , "The Hosted Merchant Link transaction is waiting for the consumer to enter missing data on the payment pages of GlobalCollect."                                                                                                   ],
      30    => ["PENDING AT GLOBALCOLLECT"                                                , "The Hosted Merchant Link transaction is waiting for the consumer to be redirected by WebCollect to the payment pages of the bank (optionally after the completion of missing data)."                                             ],
      50    => ["PENDING AT BANK (Real-time Bank Transfer)/ENROLLED (Credit Card Online)" , "The payment request and consumer have been forwarded to the payment pages of the bank./The payment request and consumer have been forwarded to the authentication pages of the card issuer."                                     ],
      55    => ["PENDING AT CONSUMER"                                                     , "The consumer received all payment details to initiate the transaction. The consumer must go to the (bank) office to initiate the payment."                                                                                       ],
      60    => ["NOT ENROLLED"                                                            , "The consumer is not enrolled for 3D Secure authentications."                                                                                                                                                                     ],
      65    => ["PENDING PAYMENT (CONSUMER AT BANK)"                                      , "The consumer is at an office to initiate a transaction. The status isused when the supplier polls the WebCollect database to verify if apayment on an order is (still) possible."                                                ],
      70    => ["INDOUBT AT BANK"                                                         , "The status of the payment is in doubt at the bank."                                                                                                                                                                              ],
      100   => ["REJECTED"                                                                , "WebCollect rejected the payment instruction."                                                                                                                                                                                    ],
      120   => ["REJECTED BY BANK"                                                        , "The bank rejected the payment."                                                                                                                                                                                                  ],
      125   => ["CANCELLED BY BANK"                                                       , "The consumer cancelled the payment while on the bank’s payment pages."                                                                                                                                                           ],
      130   => ["FAILED VERIFICATION"                                                     , "The payment has failed."                                                                                                                                                                                                         ],
      140   => ["EXPIRED AT BANK"                                                         , "The payment was not completed within the given set time limit by the consumer and is expired. The payment has failed."                                                                                                           ],
      150   => ["TIMED OUT AT BANK"                                                       , "WebCollect did not receive information regarding the outcome of the payment at the bank."                                                                                                                                        ],
      160   => ["DENIED"                                                                  , "The transaction had been rejected for reasons of suspected fraud."                                                                                                                                                               ],
      170   => ["AUTHORISATION EXPIRED"                                                   , "The authorisation is expired because no explicit settlement request was received in time."                                                                                                                                       ],
      172   => ["AUTHENTICATION_ENROLLMENT_EXPIRED"                                       , "The enrolment period was pending too long."                                                                                                                                                                                      ],
      175   => ["AUTHENTICATION_VALIDATION_EXPIRED"                                       , "The validation period was pending too long."                                                                                                                                                                                     ],
      180   => ["INVALED PARES OR NOT COMPLETED"                                          , "The cardholder authentication response from the bank was invalid or not completed."                                                                                                                                              ],
      200   => ["CARDHOLDER AUTHENTICATED"                                                , "The cardholder was successfully authenticated."                                                                                                                                                                                  ],
      220   => ["COULD NOT AUTHENTICATE"                                                  , "The authentication service was out of order, cardholder could not be authenticated."                                                                                                                                             ],
      230   => ["CARDHOLDER NOT PARTICIPATING"                                            , "The cardholder is not participating in the 3D Secure authentication program."                                                                                                                                                    ],
      280   => ["INVALED PARES OR NOT COMPLETED"                                          , "The cardholder authentication response from the bank was invalid or not completed. Authorization not possible."                                                                                                                  ],
      300   => ["AUTHORISATION TESTED"                                                    , "Authorisation tested. This payment will be re-authorised and settled offline."                                                                                                                                                   ],
      310   => ["NOT ENROLLED"                                                            , "The consumer is not enrolled for 3D Secure authentications. Authorization not possible."                                                                                                                                         ],
      320   => ["COULD NOT AUTHENTICATE"                                                  , "The authentication service was out of order, cardholder could not be authenticated. Authorization not possible."                                                                                                                 ],
      330   => ["CARDHOLDER NOT PARTICIPATING"                                            , "The cardholder is not participating in the 3D Secure authentication program. Authorization not possible."                                                                                                                        ],
      350   => ["CARDHOLDER AUTHENTICATED"                                                , "The cardholder was successfully authenticated. Authorization not possible."                                                                                                                                                      ],
      400   => ["REVISED"                                                                 , "The consumer or WebCollect has revised the payment (with other payment product)."                                                                                                                                                ],
      525   => ["CHALLENGED"                                                              , "The payment was challenged by your Fraud Ruleset and is pending. Use Process Challenged API or Web Payment Console if you choose to process further."                                                                            ],
      550   => ["REFERRED"                                                                , "The payment was referred. A ‘manual’ authorisation attempt will be made shortly."                                                                                                                                                ],
      600   => ["PENDING"                                                                 , "The payment instruction is pending waiting for a mandate (direct debit), settlement (credit card online) or acceptation (recurringorders)."                                                                                      ],
      650   => ["PENDING VERIFICATION"                                                    , "The real-time bank payment is pending verification by the batch process. If followed by 50 PENDING AT BANK, the verificationcould not be carried out successfully."                                                              ],
      800   => ["READY"                                                                   , "GlobalCollect accepted the payment instruction. For Credit Card Online the payment is authorized, but not yet settled. For a Real-time Bank Transfer the return message from the bank indicates that the payment was successful."],
      850   => ["MARKED FOR SENDING"                                                      , "Temporary status. The payment instruction was accepted and is being further processed."                                                                                                                                          ],
      900   => ["SENT"                                                                    , "Temporary status. The payment instruction was accepted and is being further processed."                                                                                                                                          ],
      900   => ["PROCESSED"                                                               , "The refund was processed."                                                                                                                                                                                                       ],
      950   => ["INVOICE_SENT"                                                            , "The invoice was printed and sent."                                                                                                                                                                                               ],
      975   => ["SETTLEMENT IN PROGRESS"                                                  , "The settlement file was sent for processing at the financiali nstitution."                                                                                                                                                       ],
      1000  => ["PAID"                                                                    , "The payment was paid."                                                                                                                                                                                                           ],
      1010  => ["ACCOUNT DEBITED"                                                         , "GlobalCollect debited the consumer account."                                                                                                                                                                                     ],
      1020  => ["CORRECTED"                                                               , "GlobalCollect corrected the payment information given."                                                                                                                                                                          ],
      1030  => ["WITHDRAWN CHARGEBACK"                                                    , "The chargeback has been withdrawn."                                                                                                                                                                                              ],
      1050  => ["REMITTED"                                                                , "The funds have been made available for remittance to the merchant."                                                                                                                                                              ],
      1100  => ["REJECTED"                                                                , "GlobalCollect rejected the payment attempt."                                                                                                                                                                                     ],
      1110  => ["REFUSED BY ACCEPTING BANK"                                               , "The acquiring bank rejected the direct debit."                                                                                                                                                                                   ],
      1120  => ["REFUSED SETTLEMENT"                                                      , "Refused settlement before payment from Acquirer."                                                                                                                                                                                ],
      1150  => ["REFUSED SETTLEMENT"                                                      , "Refused settlement after payment from Acquirer"                                                                                                                                                                                  ],
      1210  => ["REFUSED BY CONSUMER BANK"                                                , "The bank of the consumer rejected the direct debit."                                                                                                                                                                             ],
      1250  => ["BOUNCED"                                                                 , "The payment bounced."                                                                                                                                                                                                            ],
      1500  => ["CHARGED BACK BY CONSUMER"                                                , "The payment was charged back by the consumer."                                                                                                                                                                                   ],
      1510  => ["REVERSAL BY CONSUMER"                                                    , "The consumer reversed the direct debit payment."                                                                                                                                                                                 ],
      1520  => ["REVERSED"                                                                , "The payment was reversed."                                                                                                                                                                                                       ],
      1800  => ["REFUNDED"                                                                , "The payment was refunded."                                                                                                                                                                                                       ],
      1810  => ["CORRECTED REFUND"                                                        , "GlobalCollect corrected the refund information given."                                                                                                                                                                           ],
      1850  => ["REFUSED REFUND"                                                          , "Refund is refused by the Acquirer"                                                                                                                                                                                               ],
      2000  => ["ACCOUNT CREDITED"                                                        , "GlobalCollect credited the consumer account."                                                                                                                                                                                    ],
      2030  => ["WITHDRAWN REVERSED PAYOUT"                                               , "Withdrawn Reversed Payout"                                                                                                                                                                                                       ],
      2110  => ["REJECTED BY GLOBALCOLLECT"                                               , "GlobalCollect rejected the payout attempt."                                                                                                                                                                                      ],
      2120  => ["REFUSED BY ACCEPTING BANK"                                               , "The acquiring bank rejected the payout attempt."                                                                                                                                                                                 ],
      2130  => ["REFUSED BY CONSUMER BANK"                                                , "The consumer bank rejected the payout attempt."                                                                                                                                                                                  ],
      2210  => ["REVERSAL BY CONSUMER"                                                    , "The consumer reversed the payout."                                                                                                                                                                                               ],
      2220  => ["REVERSED"                                                                , "The payout was reversed."                                                                                                                                                                                                        ],
      99999 => ["CANCELLED"                                                               , "Payment/Refund/Payout attempt was cancelled by the merchant."                                                                                                                                                                    ]
    }

    class Status < Struct.new(:code, :name, :description)
      def to_s
        name
      end
    end
  end
end