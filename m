Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id DB1C4DDF51
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 23:53:30 +1000 (EST)
Message-ID: <462E0CF5.4060402@ru.mvista.com>
Date: Tue, 24 Apr 2007 17:58:13 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Using Xilinx Framebuffer on ML405 and 2.6.20.4
References: <462DCA31.4060009@computing.dundee.ac.uk>
	<528646bc0704240638m4c9dd04dlaaef0e8cdb57af53@mail.gmail.com>
In-Reply-To: <528646bc0704240638m4c9dd04dlaaef0e8cdb57af53@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Grant Likely wrote:
> On 4/24/07, Peter Mendham <petermendham@computing.dundee.ac.uk> wrote:
>> Dear all,
>>
>> I am wanting to use the Xilinx TFT controller from the ML403/5 reference
>> project (probably from ML300 as well) under a 2.6.20.4 kernel.  I have
>> Grant Likely's patchset applied in which there is a platform device
>> entry for the framebuffer.  Does anyone know if there is mainline
>> support for the Xilinx-style framebuffer?  If so, how do I enable it?  I
>> have included framebuffer support in my kernel build, but I assume I
>> need a driver also? Any tips greatly appreciated.
> 
> Heh, I've got a driver.  I just haven't published it yet.  Give me a few days...
> 
> g.
> 

We have one too :)
