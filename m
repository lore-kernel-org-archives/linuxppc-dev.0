Message-ID: <6D4DC8B4AD16D6118E8200D0B76FE262022CCB48@ONT06EXM01>
From: Barker Michael-r43496 <Michael.D.Barker@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8xx i2c refers to unspecified chip errata
Date: Wed, 9 Oct 2002 16:14:58 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi - I've been looking at the i2c driver for MPC8260.  It's the first linux driver I have studied.  I have a couple of questions.

What experimental results or theory are behind the timeout values chosen when waiting for an interrupt from a write transaction?

Also: in the drivers/i2c/i2c-algo-cpm.c or i2c-algo-8xx.c file, I see the following a few times.  What two chip errata are the comments referring to?  A specific errata number would be enlightening.

---------snip
/* Chip errata, clear enable.
*/
i2c->i2c_i2mod = 0;

---------snip
/* Chip bug, set enable here */
save_flags(flags); cli();
i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
i2c->i2c_i2cer = 0xff;
i2c->i2c_i2mod = 1;	/* Enable */
i2c->i2c_i2com = 0x81;	/* Start master */
----------snip

Thanks for your attention -

--
Michael D. Barker, Motorola SPS Canada
This email along with any attachments is classified as:
[x]  General business information


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
