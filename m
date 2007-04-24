Return-Path: <glikely@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.180])
	by ozlabs.org (Postfix) with ESMTP id 81601DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 23:38:55 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so2153505ika
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 06:38:53 -0700 (PDT)
Message-ID: <528646bc0704240638m4c9dd04dlaaef0e8cdb57af53@mail.gmail.com>
Date: Tue, 24 Apr 2007 07:38:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Mendham" <petermendham@computing.dundee.ac.uk>
Subject: Re: Using Xilinx Framebuffer on ML405 and 2.6.20.4
In-Reply-To: <462DCA31.4060009@computing.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <462DCA31.4060009@computing.dundee.ac.uk>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/24/07, Peter Mendham <petermendham@computing.dundee.ac.uk> wrote:
> Dear all,
>
> I am wanting to use the Xilinx TFT controller from the ML403/5 reference
> project (probably from ML300 as well) under a 2.6.20.4 kernel.  I have
> Grant Likely's patchset applied in which there is a platform device
> entry for the framebuffer.  Does anyone know if there is mainline
> support for the Xilinx-style framebuffer?  If so, how do I enable it?  I
> have included framebuffer support in my kernel build, but I assume I
> need a driver also? Any tips greatly appreciated.

Heh, I've got a driver.  I just haven't published it yet.  Give me a few days...

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
