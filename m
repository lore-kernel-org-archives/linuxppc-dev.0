Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Dan Malek <dan@embeddededge.com>
Cc: fabidi@ultsol.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <4002C3BB.8060805@embeddededge.com>
References: 
	 <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>
	 <3FFEEAD9.80308@embeddededge.com>
	 <1073677509.10794.14.camel@chuck.arlut.utexas.edu>
	 <3FFF276C.4060003@embeddededge.com>
	 <1073686698.3275.10.camel@chuck.arlut.utexas.edu>
	 <3FFF2B00.6@embeddededge.com>  <4002C3BB.8060805@embeddededge.com>
Content-Type: text/plain
Message-Id: <1073938758.5575.140.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Mon, 12 Jan 2004 14:19:18 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


So that leaves us back at the original question. Why does configuring
the cpu via bdi2000 prevent me from using my u-boot image? Any other
ideas?

Thanks,
Matthew

On Mon, 2004-01-12 at 09:56, Dan Malek wrote:
> Dan Malek wrote:
>
> > ..... I'll ask
> > Abatron and post the response.
>
> I received their response.  Here it is in my words.
>
> The BDI2000 doesn't care if the CCSRBAR is changed by software.
> It uses SPRs for debug control, and if it needs to access anything
> in the CCSR space, it will fetch the address from the part.
>
> So, I guess there is something else that is incorrect when we
> change the CCSRBAR.
>
> Thanks.
>
>
> 	-- Dan
>
>
--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
