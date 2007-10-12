Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id B826FDDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 06:30:58 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1174588wag
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:30:58 -0700 (PDT)
Message-ID: <fa686aa40710121330j6501a639uc19edc72095b3180@mail.gmail.com>
Date: Fri, 12 Oct 2007 14:30:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: mpc52xx bestcomm patches.
In-Reply-To: <DDF4941D-02CA-49FA-999D-8BD08740902C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710121130p7ec957bar471c2e8245bd162b@mail.gmail.com>
	<903EBFBB-D6B6-42EA-A0E3-63CAA55F6E23@kernel.crashing.org>
	<fa686aa40710121154i52e6caa0ve1130ea146b55a3f@mail.gmail.com>
	<DDF4941D-02CA-49FA-999D-8BD08740902C@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/12/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 12, 2007, at 1:54 PM, Grant Likely wrote:
>
> > On 10/12/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> >>
> >> On Oct 12, 2007, at 1:30 PM, Grant Likely wrote:
> >>
> >>> Paulus, how do you feel about merging these changes?
> >>>
> >>> This is Sylvain's series of bestcomm patches.
> >>>
> >>> http://patchwork.ozlabs.org/linuxppc/patch?id=13488
> >>> http://patchwork.ozlabs.org/linuxppc/patch?id=13489
> >>> http://patchwork.ozlabs.org/linuxppc/patch?id=13490
> >>> http://patchwork.ozlabs.org/linuxppc/patch?id=13491
> >>> http://patchwork.ozlabs.org/linuxppc/patch?id=13492
> >>> http://patchwork.ozlabs.org/linuxppc/patch?id=13493
> >>> http://patchwork.ozlabs.org/linuxppc/patch?id=13494
> >>>
> >>> There are still a few minor issues to be resolved, but Sylvain is
> >>> suffering from a severe lack of time and this series has been
> >>> stalled
> >>> for a long time because of it.  Domen and others have been
> >>> working on
> >>> drivers which use bestcomm, but they can neither get their drivers
> >>> included nor address the issues in this series because of it.
> >>>
> >>> Personally, I think it will be better to just merge it now and allow
> >>> others to address the remaining comments.  It's not like this is a
> >>> change to an old device that could be risky.
> >>
> >> I'm against this getting merged w/o addressing some of the long
> >> standing comments I've made:
> >>
> >> http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036224.html
> >> http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042632.html
> >> http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042633.html
> >>
> >> Additionally I think ALL new "libraries" like this should come with
> >> kerneldoc.
> >
> > The problem is that bestcomm is completely stalled on Sylvain.  He's
> > done good work, but he isn't able to put in the effort for the last
> > push to get it fixed and in.  But until that happens, nobody else will
> > step in to add patches on top of it to fix it up.
>
> If Sylvain doesn't have the time can't someone else pick up what he's
> done and fixup the issues with it?

As we talked about on IRC, I'm rebasing the patches now and I'll deal
with the minor issues.  There are a couple of developers actively
working on drivers which depend on bestcomm; since they are using it,
they will be able to support it too.

The code is in good shape; is well layed out and coded.  There are
developers actively using this driver in private trees.

However, that leaves the last major issue; documentation.  The
requested documentation has not been written.  However, I do not thing
this device driver should be blocked from merging over this issue.  I
think there is a better chance of it getting documented if it is
merged instead of sitting in Sylvain's queue.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
