Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1AF50DDF82
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 02:50:41 +1000 (EST)
Date: Wed, 02 May 2007 09:50:34 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: Peter Korsgaard <peter.korsgaard@barco.com>
Subject: Re: [RFC] SystemACE driver - abstract register ops
References: <463199EF.3090900@itee.uq.edu.au>	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>	<20070427173010.620DE4B8073@mail25-fra.bigfish.com>
	<87d51j5ph7.fsf@sleipner.barco.com>
In-Reply-To: <87d51j5ph7.fsf@sleipner.barco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Message-Id: <20070502165037.A1ECF1790061@mail49-blu.bigfish.com>
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

Hi Peter,

thanks for the feedback.

Yes, I agree. Having the code in mainline would be most preferable. 
However, there is always a delay between when people submit patches and 
when code actually does get into mainline. Also, it's not always 
guaranteed that the code is actually accepted into mainline. In the 
meantime there are a multitude of patches floating around which IMHO can 
be quite confusing.

The purpose of the "Xilinx git tree" is to provide a central place where 
those patches can be accumulated, including PPC and MicroBlaze. Also, as 
Xilinx is creating new IP cores, drivers for those cores will be 
directly added to that tree, eliminating the EDK->Linux horrors.

So, yes, I think it's partly a staging area for code that should make it 
into mainline, but it's also a repository for code that is not accepted 
into mainline (yet), or new, or otherwise useful to the community.

Wolfgang

Peter Korsgaard wrote:
>>>>>> "WR" == Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> writes:
> 
> Hi,
> 
> WR> The end goal is to have a kernel tree that contains ALL Xilinx
> WR> drivers and the multitude of drivers that are being
> WR> created/updated and contributed here. Having such a kernel
> WR> available will simplify the process of bringing up a new
> WR> system. The hope is that contributors will adopt the idea of
> WR> having a "Xilinx" kernel and will start using that tree as a "base
> WR> reference".
> 
> But there already is such a tree - It's called 'mainline'. I can see
> some advantage in having a Xilinx tree as a staging area, but it
> really HAS to be a temporary thing and stuff needs to be pushed to
> mainline.
> 
> WR> I will post news here as they unfold. In the meantime it would be
> WR> very interesting to hear ideas and suggestions from you. Concerns
> WR> that people have. Pitfalls to look out for etc.
> 
> Hereby my 2 cents.
> 
