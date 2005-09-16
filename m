Return-Path: <JohnsonCheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id D3292682D0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 22:09:25 +1000 (EST)
From: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
To: <wd@denx.de>
Date: Fri, 16 Sep 2005 20:09:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20050916112324.0528D352B7B@atlas.denx.de>
Message-Id: <20050916120925.D3292682D0@ozlabs.org>
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: RE: How to use kerberos in ELDK 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes. I have find out how to do it.
./install -d ppc_6xx

Thanks,
Johnson Cheng

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de] 
Sent: Friday, September 16, 2005 7:23 PM
To: JohnsonCheng
Cc: 'linux-ppc-embedded'
Subject: Re: How to use kerberos in ELDK 

In message <20050916070358.781D2422AF@denx.de> you wrote:
> 
> Maybe I meet the big trouble.
> I find no powerpc-linux-rpm in my build machine, only have
> powerpc-linux-gcc, powerpc-linux-ar .....
> What should I do?

You should really READ the documentation. It says, and I  explicitely
quoted this in my previous posting:

> You must use "${CROSS_COMPILE}rpm" instead.

So instead of trying powerpc-linux-rpm which indeed  does  not  exist
you  should  run  ppc_8xx-rpm  or whichever other architecture you're
using (alternatively ppc-rpm would work, but this is undocumented and
not recommended).

Please RTFM!


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...and the fully armed nuclear warheads, are, of  course,  merely  a
courtesy detail."
