Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id BF393B711D
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Aug 2010 20:51:36 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm/e500_tlb: Fix a minor copy-paste tracing bug
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: multipart/alternative; boundary=Apple-Mail-63--257188238
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <AANLkTimwBL42bAxa5okPeJ-y_oSCfp05_POxxRasZGFn@mail.gmail.com>
Date: Sat, 28 Aug 2010 12:51:29 +0200
Message-Id: <F3844EE1-639D-441D-A1B1-AFC6B8CB8AAF@suse.de>
References: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
	<B3286B71-599C-405E-847F-06B843A46449@suse.de>
	<AANLkTimwBL42bAxa5okPeJ-y_oSCfp05_POxxRasZGFn@mail.gmail.com>
To: Kyle Moffett <kyle@moffetthome.net>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
	Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-63--257188238
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 28.08.2010, at 07:24, Kyle Moffett wrote:

> On Fri, Aug 27, 2010 at 20:58, Alexander Graf <agraf@suse.de> wrote:
>> On 27.08.2010, at 21:06, Kyle Moffett wrote:
>>> The kvmppc_e500_stlbe_invalidate() function was trying to pass too =
many
>>> parameters to trace_kvm_stlb_inval().  This appears to be a bad
>>> copy-paste from a call to trace_kvm_stlb_write().
>>=20
>> Which kernel is this against? That trace point is already commented =
out in my tree.
>=20
> Oh, hm, I guess I haven't rebased this patch since 2.6.35-ish.  The
> trace point seems to work correctly with the fixed arguments; if
> you'll tell me which tree I should base it on I can easily resubmit.

My tree is at git://github.com/agraf/linux-2.6.git kvm-ppc-next. If you =
like I'll gladly take a patch in to enable the point again :).

Alex


--Apple-Mail-63--257188238
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><br><div><div>On 28.08.2010, at 07:24, Kyle Moffett wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div>On =
Fri, Aug 27, 2010 at 20:58, Alexander Graf &lt;<a =
href=3D"mailto:agraf@suse.de">agraf@suse.de</a>&gt; =
wrote:<br><blockquote type=3D"cite">On 27.08.2010, at 21:06, Kyle =
Moffett wrote:<br></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite">The kvmppc_e500_stlbe_invalidate() function was trying to =
pass too many<br></blockquote></blockquote><blockquote =
type=3D"cite"><blockquote type=3D"cite">parameters to =
trace_kvm_stlb_inval(). &nbsp;This appears to be a =
bad<br></blockquote></blockquote><blockquote type=3D"cite"><blockquote =
type=3D"cite">copy-paste from a call to =
trace_kvm_stlb_write().<br></blockquote></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">Which kernel is =
this against? That trace point is already commented out in my =
tree.<br></blockquote><br>Oh, hm, I guess I haven't rebased this patch =
since 2.6.35-ish. &nbsp;The<br>trace point seems to work correctly with =
the fixed arguments; if<br>you'll tell me which tree I should base it on =
I can easily resubmit.<br></div></blockquote><div><br></div><div>My tree =
is at&nbsp;<a =
href=3D"git://github.com/agraf/linux-2.6.git">git://github.com/agraf/linux=
-2.6.git</a>&nbsp;kvm-ppc-next. If you like I'll gladly take a patch in =
to enable the point again =
:).</div><div><br></div><div>Alex</div></div><br></body></html>=

--Apple-Mail-63--257188238--
