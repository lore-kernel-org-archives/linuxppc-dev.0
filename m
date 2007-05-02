Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id EEFFEDDED3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 23:23:18 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HjEnc-0001SV-JB
	for linuxppc-embedded@ozlabs.org; Wed, 02 May 2007 15:23:16 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] SystemACE driver - abstract register ops
References: <463199EF.3090900@itee.uq.edu.au>
	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
	<20070427173010.620DE4B8073@mail25-fra.bigfish.com>
Date: Wed, 02 May 2007 15:23:16 +0200
In-Reply-To: <20070427173010.620DE4B8073@mail25-fra.bigfish.com> (Wolfgang
	Reissnegger's message of "Fri, 27 Apr 2007 10:30:08 -0700")
Message-ID: <87d51j5ph7.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "WR" == Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> writes:

Hi,

WR> The end goal is to have a kernel tree that contains ALL Xilinx
WR> drivers and the multitude of drivers that are being
WR> created/updated and contributed here. Having such a kernel
WR> available will simplify the process of bringing up a new
WR> system. The hope is that contributors will adopt the idea of
WR> having a "Xilinx" kernel and will start using that tree as a "base
WR> reference".

But there already is such a tree - It's called 'mainline'. I can see
some advantage in having a Xilinx tree as a staging area, but it
really HAS to be a temporary thing and stuff needs to be pushed to
mainline.

WR> I will post news here as they unfold. In the meantime it would be
WR> very interesting to hear ideas and suggestions from you. Concerns
WR> that people have. Pitfalls to look out for etc.

Hereby my 2 cents.

-- 
Bye, Peter Korsgaard
