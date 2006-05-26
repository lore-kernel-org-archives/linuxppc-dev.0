Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 3C1A767A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 17:49:52 +1000 (EST)
From: Roger Larsson <roger.larsson@norran.net>
To: sandeep malik <malik_mca2000@yahoo.co.in>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Help Needed: floating point used in kernel (task=c0398410,
	pc=3184)
Date: Fri, 26 May 2006 09:49:48 +0200
References: <20060526073815.32337.qmail@web8401.mail.in.yahoo.com>
In-Reply-To: <20060526073815.32337.qmail@web8401.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200605260949.48627.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On fredag 26 maj 2006 09.38, you wrote:
> Hi Roger,
>
> =A0 The problem has been resolved...the issue was in the make
> file.....actually we were cpmiling the code with gclibc and linking it wi=
th
> uClibc which was causing the problem.....But this was real test i faced
> till now as all the tricks realted to the message were failed.....any ways
> thanks for ur help....=20
> =A0 Regards,
> =A0 Malik

Now I am confused!

How could this cause
"floating point used in kernel (task=3Dc0398410, pc=3D3184)"

Both uClibc and gclibc are user land libraries. They should not be able to
cause an kernel floating point operation. No user land code should be able
to do this!

Or is it your kernel linked with uClibc/gclibc? I do not think that is the
right thing to do...

/RogerL
