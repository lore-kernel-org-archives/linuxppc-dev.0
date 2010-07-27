Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 51F09B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 16:37:38 +1000 (EST)
Received: by pwi6 with SMTP id 6so401367pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Jul 2010 23:37:36 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 Jul 2010 12:07:36 +0530
Message-ID: <AANLkTimcDkbfezvSNe_2Qc1tHGWtc4A6jHX07QAOvhNO@mail.gmail.com>
Subject: Memory Mapping DMA Buffers in User Space
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636458c7ea133d9048c58bc7a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636458c7ea133d9048c58bc7a
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am new to linux device driver development and I'm trying to learn the
memory mapping. Currently I am trying to memory map a dma buffer allocated
using pci_alloc_consistent() function.

Now what exactly I want is that whenever I map a char device from user space
program, let say /dev/test, internally that DMA buffer gets memory mapped to
the user space? Also what should I pass as the length parameter in the
mmap() function?

Thanks in advance
Ravi Gupta

--001636458c7ea133d9048c58bc7a
Content-Type: text/html; charset=ISO-8859-1

Hi,<br>
<br>
I am new to linux device driver development and I&#39;m trying to learn the<br>
memory mapping. Currently I am trying to memory map a dma buffer allocated using pci_alloc_consistent() function. <br>
<br>
Now what exactly I want is that whenever I map a char device from user 
space program, let say /dev/test, internally that DMA buffer gets memory
 mapped to the user space? Also what should I pass as the length 
parameter in the mmap() function? <br>
<br>
Thanks in advance<br>
Ravi Gupta

--001636458c7ea133d9048c58bc7a--
