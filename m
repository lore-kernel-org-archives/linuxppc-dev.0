Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 75644DDE9A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 04:20:01 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1818333pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Jan 2008 09:20:00 -0800 (PST)
Message-ID: <479CAF56.30306@gmail.com>
Date: Sun, 27 Jan 2008 14:20:38 -0200
From: Ricardo Severo <severo.ricardo@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Linux boot on a ppc 405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am working with a Xilinx Virtex II Pro  evaluation board, wich has two 
PowerPC 405 and I'm trying to boot a vanilla linux kernel 2.6.23.14. 
Until now I've manged to make it uncompress the kernel, but it doesn't boot.
My question is how the initial execution (the one who uncompresses the 
kernel image) transfers the processor to the kernel itself. I've looked 
in the arch/ppc/boot/simple/relocate.S code and it jumps to the position 
0x0 after uncompressing, is it right? The kernel is uncompressed at that 
position?

Thanks,

-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
