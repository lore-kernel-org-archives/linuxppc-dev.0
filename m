Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5301DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 01:47:04 +1000 (EST)
Received: from [134.82.224.137] (wifi224-137.bucknell.edu [134.82.224.137])
	(authenticated bits=0)
	by ivory.bucknell.edu (8.14.2/8.14.2) with ESMTP id m6BEQR9c023503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Fri, 11 Jul 2008 10:26:27 -0400
Message-ID: <48776D93.5080504@bucknell.edu>
Date: Fri, 11 Jul 2008 10:26:27 -0400
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: insmod: unresolved symbol XIo_In32/XIo_Out32 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Is anybody familiar with the following error?

insmod: unresolved symbol XIo_In32
insmod: unresolved symbol XIo_Out32

I am trying to write a device driver for a Custom IP and get it to run 
on a Xilinx ML310's Linux OS. I am using Xilinx EDK 10.1 and MontaVista 
Linux version 2.4.20_mvl31-ml300. I ran into this error when trying to 
load my module into the kernel. When I try to load the module using 
insmod on the ".o" file, the module refuses to load and gives me the 
unresolved symbol error message. I actually stumbled upon an older 
posting from June 2006 on this mailing list that described a similar 
problem, but those suggestions did not help me. Maybe two years later, 
there are more ideas/suggestions/solutions to this problem?

Thanks!


-Juliana
