Date: Thu, 29 Mar 2001 09:36:48 +0530 (IST)
From: "Srinivas Rao.M" <msrao@vxl.co.in>
To: Jones Madhuri <madhuri_jones@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What does instruction LA mean?
In-Reply-To: <20010328053251.30486.qmail@web13605.mail.yahoo.com>
Message-ID: <Pine.SCO.3.91.1010329091608.22173A-100000@vayudoot>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi madhuri,
 	The LA here is a macro. I am not sure about the linux. but in the
pSOS+ i have seen a macro written in assembly language, which does the
'loading of address to a register' job.

Just check the assembly source files, you may find macro something like this.

  .macro    LA reg,symbol
  lis       reg,%hiadj(symbol)
  addi      reg,reg,%lo(symbol)
  .endm


such macros are written to load the value(constant) in to a register.

cheers,
srini...


On Tue, 27 Mar 2001, Jones Madhuri wrote:

>
> Hello,
>
> I am novice in Power PC assembly code and I am trying
> compile in following code (written by someone else)
> into head_8xx.S.
>
> This function has instruction like
>
> mfspr r3, IC_CST
> LA r4, IC_CST_LEN
>
> However the hardhat assembler doesn't understand the
> mnemonic LA, is LA same as add immediate instruction?
> addi r4, r4, IC_CST_LEN
>
> Please help!!
>
> Thanks.
>
> M.J.
>
> Get email at your own domain with Yahoo! Mail.
> http://personal.mail.yahoo.com/?.refer=text
>
>

--

We are responsible for what we are, and whatever we wish ourselves to be, we
have the power to make ourselves. If what we are now has been the result of
our own past actions, it certainly follows that whatever we wish to be in
future can be produced by our present actions; so we have to know how to act.
-Swami Vivekananda


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
