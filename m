Date: Tue, 24 Aug 2004 12:07:07 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Reply-To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <149461203.20040824120707@varma-el.com>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: Gabor Janak <g.janak@unicontrol.de>,
	linuxppc-embedded@lists.linuxppc.org, Wolfgang Denk <wd@denx.de>
Subject: [RFC] Re: BestComm and fec
In-Reply-To: <412A4B69.7000305@246tNt.com>
References: <412A4B69.7000305@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

> Andrey: Gabor has a working fec.c implementation.

> Apparently, you've both worked out a version of bestcomm for 2.6. But
> you both based it on old code. (even non GPL).

Terrible, may be its time to create special project for MPC5200 (if it
doesn't exist in somewhere in I-net)? First intention - sourceforge.
Comments/suggestions?

Sylvain, Wolfgang I know you already have projects. But in case of
Sylvain, as I understand, his project on his homepage.
In case of Wolfgang, I'm not sure that DENX will happy to share their
internal CVS with all I-net for write access. Am I right?

> I've just tried just taking the newer one and stick it in 2.6 with the
> fec Gabor sent, but it just crashes so it need more work ;) Dale
> Farnsworth just said it'll look into it and porting new bestcomm as well.

My fec port work ok.

> To resume the "close" future I'm planning :

> I'm busy for two weeks ( I was planning on finishing other stuff earlier
> and didn't work out finally ;( ). So I work less on the MPC but after
> that, that's a full time assignment.

>  - USB: Dale's patch are on their way to the official kernel. Once they
> are in, He or I will send the necessary MPC5200 dependent stuff.
>  - PCI: I'm working on that now, just brushing it up then I'll put it on
> my tree and require testing
>  - I2C: Waiting Adrian Cox patches to be in official tree ( they are in
> -mm ), then apply mpc5200 specifics.
>  - BestComm : Dale (the original fec writing among other things) is
> adapting the newer bestcommcode and cleaning the fec driver as well.
>  - IDE: Once  I get PCI in my tree, I'll look at IDE, a DMA-less version
> at first.

And CAN, RTC, and possible CRC32/16 (if it will fast enough) :).

--
Best regards,
 Andrey Volkov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
