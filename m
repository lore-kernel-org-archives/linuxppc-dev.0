Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id A076FDDEE6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Mar 2007 05:15:30 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1014564nfc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 09 Mar 2007 10:15:28 -0800 (PST)
Message-ID: <528646bc0703091015t1e3e2485s5149927c0d4c9223@mail.gmail.com>
Date: Fri, 9 Mar 2007 11:15:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: Xilinx , Ml403, Linux And Money!
In-Reply-To: <BAY115-W4270CF08F77CA41348714B2850@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W4270CF08F77CA41348714B2850@phx.gbl>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/4/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>
> Hi all,
>
> Money seems to be really important, even when your product is still in beta releases ....
>
> At least, my recent experince with the latest release of EDK and more than two weeks of trying different approaches to compile the kernel for ml403 is telling me that ...

Welcome to the world of embedded development.  Some boards are easy,
some require a fair bit of knowledge to get working.  The Virtex ppc
port still requires a fair bit of elbow grease.

>
> At the begining stages of my work, some one here told me , "simply use edk 8.2.02 to generate the linux bsp and then copy the entire files to kernel tree and you are there " ... working and working and working ... I came to this solution at last : ( again another sentence from some one else here ) " I did not use edk generated files for compiling the kernel, .... I just used xparameters.h and then used the paulus patch " Very interestingly, I'm seeing that the paulus patch is not applied on the main kernel tree , I don't really understand why?

Mostly because nobody has shepherded it into mainline.  Most people
are using the Xilinx drivers, but the xilinx drivers as-is aren't
really suitable for inclusion in mainline (style/layout/conventions
don't match).  Until someone is able to dedicate a fair bit of time to
get the Virtex drivers sorted out, the situation is unlikely to
improve.

>
> Another interesting point is that the GIT development tree of montavista for ML403 is 9 months old ....

That's why I stick with mainline, and I forward port the drivers that I need.

>
> Finally, you see some new app notes from xilinx xapp969 that tells you that you should be able to compile the kernel with exactly no problem and very easily if you have purchased either one of montavista or wind river dev kits.... So, Is the version of kernel used in these kits different than what montavista provides as it's git tree? It should be different because I'm sure that copying EDK files into the git tree provided by them just results some errors.

I really don't know, you'd need to ask MV.

>
> Finally we see montavista asking for your registration before allowing you to download the preview kit, and then their answer "you are not allowed to access the prev kit because .... ..... "
>
> I was expecting linux kernel source to be free .... But it seems that it is not free at all.

The GPL license grants to the ability to use/modify/distribute the
kernel source.  It also guarantees that if someone provides you with a
binary image, then you get access to the source code also with all the
rights granted by the GPL.  It does *not* compel someone to give you a
copy of their source/binaries if they don't want to distribute them to
you.  Free refers to freedom to use it, *not* free cost.

That being said; all the components you need are available in the open
without cost, but it requires some effort to piece them together.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
