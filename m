From: benh@kernel.crashing.org
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Thu, 11 Apr 2002 17:50:11 +0100
Message-Id: <20020411165012.25649@mailhost.mipsys.com>
In-Reply-To: <0204111624.AA28797@ivan.Harhan.ORG>
References: <0204111624.AA28797@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Don't get to conclusions so fast. We have already a whole bunch of new
>> machines support pending in _devel that has to be merged, and that will
>> happen after 2.4.19. Things aren't fast on a stable kernel, but that's
>> the way it should be.
>
>Then why won't you accept my PPCStar port into 2_4_devel?

I didn't say I didn't accept it. Paulus is the one to ultimately decide
about that though, but I understand if he wants to put a hold on new
boards until at least _devel gets merged into 2.4

>> Not having it as a module may prevent pcmcia modems from working.
>
>OK, now I see the fundamental conflict of interest. Your machines and mine
>can't coexist in the same kernel I guess then because mine can't work
with the
>serial driver as a module (because it's the system console) and yours can't
>work with it compiled in because of PCMCIA. Let's have separate
>CONFIG_CHRP_PMAC_PREP and CONFIG_HEC_PPCSTAR then.

No, let's fix the brain-damaged serial driver ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
