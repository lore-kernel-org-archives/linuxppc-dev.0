Return-Path: <rameshmrm@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by ozlabs.org (Postfix) with ESMTP id 85787DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 19:25:04 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1386247wxd
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 02:25:01 -0700 (PDT)
Message-ID: <a12d1c3d0708210225k54a89463jdb58b199da059717@mail.gmail.com>
Date: Tue, 21 Aug 2007 14:55:01 +0530
From: "ramesh mrm" <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1599_28799418.1187688301539"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1599_28799418.1187688301539
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

------=_Part_1599_28799418.1187688301539
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div id="mb_0">Hai,<br>&nbsp; &nbsp; &nbsp; &nbsp; I am using the kernel 2.6.21. In the file<br>(arch/ppc/syslib/pci_auto.c) we have the function pciauto_bus_scan(). In<br>this function it will skip the host birdge. But in the arch/powepc<br>
directory we don&#39;t have that types of file and the function <br>pciauto_bus_scan() also removed.<br>I want to know where the function was moved in arch/powerpc directory ?<br>How the host bridge was skip in the arch/powerpc directory.
<br><br>Thanks and Regards<br><span class="sg">Ramesh<br></span></div>

------=_Part_1599_28799418.1187688301539--
