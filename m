Date: 1 Apr 2002 13:01:05 -0000
Message-ID: <20020401130105.30420.qmail@mailweb11.rediffmail.com>
MIME-Version: 1.0
From: "ashish  anand" <ppc4@rediffmail.com>
Reply-To: "ashish  anand" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: any pointer...?
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a specific problem in 405gp on embeddedplanet board.

it is gets hanged in MEMCPY() below.

void __init
Board_init(unsigned long r3, unsigned long r4, unsigned
long r5,unsigned long r6, unsigned long r7)
{
         /*
          * If we were passed in a board information, copy it into
the
          * residual data area.
          */
         if (r3) {
          memcpy((void *)__res, (void *)(r3 +KERNELBASE),
   sizeof(bd_t));
         }

i am using board reset ( bl reset) type of macro for debugging for
detemining the hang .

if i put bl reset  macro before memcpy the board gets reset but
not after the memcpy .

abort being ..._GLOBAL(abort)
                mfspr   r13,SPRN_DBCR
                oris   r13,r13,DBCR_RST(DBCR_RST_SYSTEM)@h
                mtspr   SPRN_DBCR,r13


can anybody help me with any pointer....

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
