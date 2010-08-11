Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 1D4BBB70B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Aug 2010 16:09:28 +1000 (EST)
Received: by pzk5 with SMTP id 5so5474530pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Aug 2010 23:09:27 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Aug 2010 11:39:26 +0530
Message-ID: <AANLkTikYwtumQVORC6wCFexmHTf90zcyuC1V08PkjhCQ@mail.gmail.com>
Subject: DMA transfer within kernel space
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=001636458c7e8be229048d86171a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636458c7e8be229048d86171a
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am new to linux device driver development and I'm trying to learn the
DMA transfer. Currently I have created a  DMA buffer using
pci_alloc_consistent() function. Since I don't have a real DMA enabled pci
device, so I am thinking of transfer the data in the DMA buffer to some
other buffer within kernel space(let say created through kmalloc) using
DMA.

Is it possible to do DMA transfer within kernel space? If yes, please
provide some sample code for the same.

Thanks in advance
Ravi Gupta

--001636458c7e8be229048d86171a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am new to linux device driver development and I&#39;m trying t=
o learn the<br>DMA transfer. Currently I have created a=A0 DMA buffer using=
 pci_alloc_consistent() function. Since I don&#39;t have a real DMA enabled=
 pci device, so I am thinking of transfer the data in the DMA buffer to som=
e other buffer within kernel space(let say created through kmalloc) using D=
MA.=A0 <br>
<br>Is it possible to do DMA transfer within kernel space? If yes, please p=
rovide some sample code for the same.<br><br>Thanks in advance<br>Ravi Gupt=
a<br>

--001636458c7e8be229048d86171a--
