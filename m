To: Anil Giri <anil@india.tejasnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: _PAGE_WRITETHRU option in 8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Jul 2003 18:14:00 +0700."
             <1057841040.3f0d5f9022327@pop-mail.india.tejasnetworks.com>
Date: Thu, 10 Jul 2003 15:00:29 +0200
Message-Id: <20030710130034.D66D4C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1057841040.3f0d5f9022327@pop-mail.india.tejasnetworks.com> you wrote:
>
>   I am using linuxppx_2_4_20 from denx and i can;t find the _PAGE_WRITETHRU
> option in include/asm-ppc/pgtable.h for 8xx. Is it replaced or ommitted?

You must be using some different source tree. This is what I see:

	-> grep PAGE_WRITETHRU include/asm-ppc/pgtable.h
	#define _PAGE_WRITETHRU 0x008   /* W: caching is write-through */
	#define _PAGE_WRITETHRU 0x00000800              /* H: W bit */
	#define _PAGE_WRITETHRU 0x040   /* W: cache write-through */



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Here's a fish hangs in the net like a poor man's right in  the  law.
'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
