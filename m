To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: can the 8xx patch configuration be made more comprehensible? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Jul 2004 08:23:59 EDT."
             <Pine.LNX.4.60.0407210807460.4518@dell.enoriver.com>
Date: Wed, 21 Jul 2004 14:59:16 +0200
Message-Id: <20040721125921.119FBC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0407210807460.4518@dell.enoriver.com> you wrote:
>
>    does it really have to be this painful?  a number of simple
> questions:
>
> * how many patches are there?

There are least 3 that are relevant here:

- MPC850 microcode patch for relocating I2C/SPI parameters.
- MPC860 microcode patch for relocating I2C/SPI parameters
  (to be used with MPC823, MPC855, ... as well; yes, here the
  823 is NOT in the same group as the 850)
- MPC823 (and 850?) patch for automatic USB start-of-frame (SOF)
  token generation

> * which ones can be selected independently from the others?  and can
>    they be made separate selections in the config menu?  (does it even
>    make sense to select only some of the possible patches?)

Depending on the  processor  model  and  requirements  you  may  need
patches 1, 1+3, 2, 2+3, or 3.

> * and can they be documented so the builder knows what the purpose of
>    the patch is?

They can (like in our CVS tree :-)

> * and can the SMC patch be moved out of the source file and made a
>    config-time selection along with the others (might be difficult
>    given the necessity of editing the uart driver file).

Of course this can be done.

> anyway, you get the idea.

How about submitting a patch?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No one wants war.
	-- Kirk, "Errand of Mercy", stardate 3201.7

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
