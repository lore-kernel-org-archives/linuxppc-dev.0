Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.197])
	by ozlabs.org (Postfix) with ESMTP id C556A67B88
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 04:49:46 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so862592nzh
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 05 Sep 2006 11:49:45 -0700 (PDT)
Message-ID: <198592450609051149h47423ebev9c94eb8aefc2a3fb@mail.gmail.com>
Date: Tue, 5 Sep 2006 18:49:44 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: "Jon Scully" <jonscully@gmail.com>
Subject: Re: MPC8245 reset register
In-Reply-To: <53107f6e0609021647l1f1cd84du496e3cd7219b603@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_117782_17220215.1157482184899"
References: <198592450609021546x57c71e48r9aed561b61f6e8aa@mail.gmail.com>
	<53107f6e0609021647l1f1cd84du496e3cd7219b603@mail.gmail.com>
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

------=_Part_117782_17220215.1157482184899
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jon,

Could you elaborate it a bit? I wrote 0x1 to PI register, but CPU hangs
without resetting. I'm kind of curious what's the proper way to reset the
8245 CPU? For anyone who doesn't know MPC8245, which is 603e core.

Thanks a lot.

- Reeve

On 9/2/06, Jon Scully <jonscully@gmail.com> wrote:
>
> On 9/2/06, Reeve Yang <yang.reeve@gmail.com> wrote:
> > Can anyone tell me which register should I use to do soft reset on
> MPC8241/5
> > CPU? I searched its manuall but only find EPIC to send SRESET exception
> on
> > offset 0x41090.
> >
> >  Thanks.
> >
> >  - Reeve
> >
>
> Use the reset instruction (RST in assembly).
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_117782_17220215.1157482184899
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jon, <br>
<br>
Could you elaborate it a bit? I wrote 0x1 to PI register, but CPU hangs
without resetting. I'm kind of curious what's the proper way to reset
the 8245 CPU? For anyone who doesn't know MPC8245, which is 603e core.<br>
<br>
Thanks a lot.<br>
<br>
- Reeve<br><br><div><span class="gmail_quote">On 9/2/06, <b class="gmail_sendername">Jon Scully</b> &lt;<a href="mailto:jonscully@gmail.com">jonscully@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 9/2/06, Reeve Yang &lt;<a href="mailto:yang.reeve@gmail.com">yang.reeve@gmail.com</a>&gt; wrote:<br>&gt; Can anyone tell me which register should I use to do soft reset on MPC8241/5<br>&gt; CPU? I searched its manuall but only find EPIC to send SRESET exception on
<br>&gt; offset 0x41090.<br>&gt;<br>&gt;&nbsp;&nbsp;Thanks.<br>&gt;<br>&gt;&nbsp;&nbsp;- Reeve<br>&gt;<br><br>Use the reset instruction (RST in assembly).<br>_______________________________________________<br>Linuxppc-embedded mailing list<br>
<a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div>
<br>

------=_Part_117782_17220215.1157482184899--
