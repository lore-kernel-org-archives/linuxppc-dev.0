Message-ID: <20020125055315.55328.qmail@web20408.mail.yahoo.com>
Date: Thu, 24 Jan 2002 21:53:15 -0800 (PST)
From: Venkat Raghu <venkatraghu2002@yahoo.com>
Subject: "sc" ...
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,

  I think in order to generate system call exception
  using instruction "sc", we have to update  EVPR
  with "mtspr". So that corresponding handler will be
  called based upon the contents of EVPR.

   But in source code that I am seeing has something
  like:
   mr r6,r3
   ori r3,r5, value
   li  r0,somevalue
   sc
   ....
   ...

   Even if EVPR is not updated with any value  a
   Machine check interrupt is being generated.
  1) Kindly clarify how control goes to machine check
   interrupt handler, is it beacuse of call to "sc"
   or some other event triggers interrupt?
  2) Why "sc" is being called without setting EVPR.

  I have not subscribed to this list. Kindly mail me
  at venkatraghu2002@yahoo.com
  Thankyou.
  Venkat.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
