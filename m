Subject: Re: software floating point
To: zzu@doit.ajou.ac.kr (AV9N1T)
Date: Tue, 29 Aug 2000 15:48:59 +1100 (EST)
Cc: cal_erickson@mvista.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <002901c0116f$380a1200$481877d3@ajou.ac.kr> from "AV9N1T" at Aug 29, 2000 01:11:09 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000829044859.609DCC2@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


=?iso-8859-1?B?wda5zrHU?= writes:
> I have some questions...about soft-floating point...

I suggest you read the section in the HOWTO on the subject, at:
    http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO-13.html

> When compile third step, shoud I use some options to support software floating point?

You need to configure the compiler to make -msoft-float the default in step 2,
and apply the glibc patch to make it work correctly on the 860 before you do
step 3.

> To support software floating point, which steps should I use some special options in above steps and what option is it need?

The options are mentioned in the HOWTO.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
