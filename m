Return-Path: <KendallB@scitechsoft.com>
Received: from mail.scitechsoft.com (mail.scitechsoft.com [63.195.13.67])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46FA12BE83
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 09:02:59 +1100 (EST)
Received: from KENDALLB (nat.scitechsoft.com [63.195.13.75])
	by mail.scitechsoft.com (8.12.8/8.12.8) with ESMTP id iBALJwCl016246
	for <linuxppc-embedded@ozlabs.org>; Fri, 10 Dec 2004 13:19:58 -0800
From: "Kendall Bennett" <KendallB@scitechsoft.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 10 Dec 2004 13:23:06 -0800
MIME-Version: 1.0
Message-ID: <41B9A33A.21673.5DDD7F64@localhost>
Content-type: text/plain; charset=US-ASCII
Subject: Write Combining on PowerPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Guys,

We are working on some PowerPC machines and noticed that the boxes don't 
appear to support the equivalent of Write Combining that we get on x86 
boxes. Copies to Video Memory on our Motorola Sandpoint box run about 
10Mb/s, which is terribly, terribly slow!  

Does anyone know if it is possible to do something similar to Write 
Combining for the PowerPC architecture, to speed up CPU access to the 
linear framebuffer? Part of the problem is that for video overlay support 
(not motion compensation) you have to dump the entire YUV frame into 
video memory for the hardware overlay, and even on a 1GHz PPC box playing 
an MPEG2 stream is not possible as X takes up over 80% of the CPU just to 
copy the YUV data to video memory!  

Obviously bus mastering will help solve this problem, but it would be 
better if there was a way to enabling faster CPU access to the 
framebuffer as well.  

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~
