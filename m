Return-Path: <mahendravarman15@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 6C726DDF06
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 23:02:48 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so253674nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 06:02:45 -0700 (PDT)
Message-ID: <4ac2955e0807190602g4dcf7ddauc07dd8441ef678cc@mail.gmail.com>
Date: Sat, 19 Jul 2008 18:32:45 +0530
From: "mahendra varman" <mahendravarman15@gmail.com>
To: "selvamuthukumar v" <v.selvamuthukumar@gmail.com>
Subject: Re: No filesystem could mount root
In-Reply-To: <790896390807190452n7197924ma07bfd4c3431eb89@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_47519_30307132.1216472565622"
References: <4ac2955e0807180700u6184562duc128049245e37fdc@mail.gmail.com>
	<790896390807190452n7197924ma07bfd4c3431eb89@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_47519_30307132.1216472565622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> There are no messages from the kernel that it's trying NFS. You can
> check the boot arguments you are passing to the kernel.
>

The boot arguments are passed correctly only.

setenv bootargs console=ttyS0,57600 root=/dev/nfs
nfsroot=192.168.0.6:/root/FILESYSTEM/target/target-minimal
ip=192.168.0.200:192.168.0.6:192.168.0.1:255.255.255.0::eth0

still Iam getting the above said error

Any clue??

------=_Part_47519_30307132.1216472565622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">There are no messages from the kernel that it&#39;s trying NFS. You can<br>

check the boot arguments you are passing to the kernel.<br>
</blockquote></div><br>The boot arguments are passed correctly only.<br><br>setenv bootargs console=ttyS0,57600 root=/dev/nfs nfsroot=192.168.0.6:/root/FILESYSTEM/target/target-minimal ip=192.168.0.200:192.168.0.6:192.168.0.1:255.255.255.0::eth0<br>
<br>still Iam getting the above said error<br><br>Any clue??<br><br><br></div>

------=_Part_47519_30307132.1216472565622--
