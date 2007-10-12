Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by ozlabs.org (Postfix) with ESMTP id 39750DDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 04:54:15 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so756405nzh
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 11:54:14 -0700 (PDT)
Message-ID: <fa686aa40710121154i52e6caa0ve1130ea146b55a3f@mail.gmail.com>
Date: Fri, 12 Oct 2007 12:54:13 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: mpc52xx bestcomm patches.
In-Reply-To: <903EBFBB-D6B6-42EA-A0E3-63CAA55F6E23@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710121130p7ec957bar471c2e8245bd162b@mail.gmail.com>
	<903EBFBB-D6B6-42EA-A0E3-63CAA55F6E23@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
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
> On Oct 12, 2007, at 1:30 PM, Grant Likely wrote:
>
> > Paulus, how do you feel about merging these changes?
> >
> > This is Sylvain's series of bestcomm patches.
> >
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13488
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13489
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13490
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13491
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13492
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13493
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13494
> >
> > There are still a few minor issues to be resolved, but Sylvain is
> > suffering from a severe lack of time and this series has been stalled
> > for a long time because of it.  Domen and others have been working on
> > drivers which use bestcomm, but they can neither get their drivers
> > included nor address the issues in this series because of it.
> >
> > Personally, I think it will be better to just merge it now and allow
> > others to address the remaining comments.  It's not like this is a
> > change to an old device that could be risky.
>
> I'm against this getting merged w/o addressing some of the long
> standing comments I've made:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036224.html
> http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042632.html
> http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042633.html
>
> Additionally I think ALL new "libraries" like this should come with
> kerneldoc.

The problem is that bestcomm is completely stalled on Sylvain.  He's
done good work, but he isn't able to put in the effort for the last
push to get it fixed and in.  But until that happens, nobody else will
step in to add patches on top of it to fix it up.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
