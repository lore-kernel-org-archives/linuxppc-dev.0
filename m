Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id AB7A4DEA07
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 19:53:11 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so364459rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:53:10 -0700 (PDT)
Message-ID: <319b0ac50808220253s1652f72alaff31be5eaef4244@mail.gmail.com>
Date: Fri, 22 Aug 2008 11:53:10 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Initrd
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_32075_33261448.1219398790263"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_32075_33261448.1219398790263
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am using linux 2.6.26 on a powerpc board. I would like to use a initrd. So
I set the initrd option in the kernel. But when I boot Linux, it crashes
before  start_kernel(). And after the configuration of the MMU. The last
words of the prompt are :
Probing machine type ...
  MPC7448 on IAD68 ... match !
id mach(): done
MMU:enter
MMU:hw init
hash:enter
hash:find piece
hash:patch
hash:done
MMU:mapin
MMU:setio
MMU:exi

Can you help me ?

------=_Part_32075_33261448.1219398790263
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>
<br>
I am using linux 2.6.26 on a powerpc board. I would like to use a
initrd. So I set the initrd option in the kernel. But when I boot
Linux, it crashes before&nbsp; start_kernel(). And after the
configuration of the MMU. The last words of the prompt are : <br>
Probing machine type ...<br>
&nbsp; MPC7448 on IAD68 ... match !<br>
id mach(): done<br>
MMU:enter<br>
MMU:hw init<br>
hash:enter<br>
hash:find piece<br>
hash:patch<br>
hash:done<br>
MMU:mapin<br>
MMU:setio<br>
MMU:exi<br>
<br>
Can you help me ?<br>

------=_Part_32075_33261448.1219398790263--
