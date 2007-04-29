Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 28E58DDF36
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Apr 2007 15:24:06 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so828092ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 22:24:05 -0700 (PDT)
Message-ID: <528646bc0704282224r26d9d19cu35fffa736e9f9432@mail.gmail.com>
Date: Sat, 28 Apr 2007 23:24:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "roger blofeld" <blofeldus@yahoo.com>
Subject: Re: Current kernel with all patches for MPC5200
In-Reply-To: <196297.82202.qm@web53501.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <196297.82202.qm@web53501.mail.re2.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/28/07, roger blofeld <blofeldus@yahoo.com> wrote:
> Matthias,
>  I would suggest http://git.secretlab.ca/cgi-bin/gitweb.cgi or http://gitbits.246tnt.com/gitweb/gitweb.cgi?p=linux-2.6-mpc52xx.git;a=summary or www.denx.de as starting points.
>
>  Does anyone know if patches from these repositories are destined to be in the mainline kernel any time soon? Last I heard 2.6.22 was the target to get things like Bestcomm support in Linus' kernel.

It probably won't hit 2.6.22.  :-(  Neither Sylvain or I have had time
to get the latest bestcom/eth code suitable for submission, and it is
unlikely that we will get it done before the merge window closes.
Best bet is to use the working (but ugly) eth driver in the above git
trees.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
