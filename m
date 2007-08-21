Return-Path: <rameshmrm@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id C23ECDDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 19:24:29 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so1183524wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 02:24:28 -0700 (PDT)
Message-ID: <a12d1c3d0708210224i4e23394es4d3b095d9eb16e17@mail.gmail.com>
Date: Tue, 21 Aug 2007 14:54:27 +0530
From: "ramesh mrm" <rameshmrm@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1587_1871621.1187688267787"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_1587_1871621.1187688267787
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hai,
        I am using the kernel 2.6.21. In the file
(arch/ppc/syslib/pci_auto.c) we have the function pciauto_bus_scan(). In
this function it will skip the host birdge. But in the arch/powepc
directory we don't have that types of file and the function
pciauto_bus_scan() also removed.
I want to know where the function was moved in arch/powerpc directory ?
How the host bridge was skip in the arch/powerpc directory.

Thanks and Regards
Ramesh

------=_Part_1587_1871621.1187688267787
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hai,<br>&nbsp; &nbsp; &nbsp; &nbsp; I am using the kernel 2.6.21. In the file<br>(arch/ppc/syslib/pci_auto.c) we have the function pciauto_bus_scan(). In<br>this function it will skip the host birdge. But in the arch/powepc<br>directory we don&#39;t have that types of file and the function
<br>pciauto_bus_scan() also removed.<br>I want to know where the function was moved in arch/powerpc directory ?<br>How the host bridge was skip in the arch/powerpc directory.<br><br>Thanks and Regards<br>Ramesh<br>

------=_Part_1587_1871621.1187688267787--
