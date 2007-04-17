Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 16F48DDED2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 17:48:14 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so81063ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 00:48:13 -0700 (PDT)
Message-ID: <528646bc0704170048u25cd535ar783c737bb47d9fdf@mail.gmail.com>
Date: Tue, 17 Apr 2007 01:48:13 -0600
From: "Grant Likely" <glikely@gmail.com>
To: "Wolfgang Reissnegger" <wolfgang.reissnegger@xilinx.com>,
	"Linux PPC" <linuxppc-embedded@ozlabs.org>
Subject: Re: git tree
In-Reply-To: <20070417022050.26A645C0062@mail41-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070417022050.26A645C0062@mail41-blu.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/16/07, Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> wrote:
> Hi Grant,
>
> just checked out your virtex-dev branch. I noticed that you also have a
> virtex-temac and a virtex-sysace branch that got merged into the
> virtex-dev branch.
>
> I was wondering what your branching strategy is. How is your workflow
> if, say a TEMAC bug is being fixed? Do you plan on removing the
> individual driver branches around? In which branches do you fix the
> bugs? What do you pull from where?

I haven't quite decided yet.  The -temac and -sysace branches are a
bit of an experiment.  I thought it might be a good idea to maintain
the drivers in seperate branches so it is easy to get a diff on just
that driver; but the individual drivers are pretty seperate anyway (in
different directories).  I think I'll probably drop the -temac and
-sysace branches, and just maintain all my changes in the -dev branch.
 The -forupstream branch is specifically for patches that are due to
go upstream.  I'll add patches there when I think they are suitable
for mainline, and post them to the list.

>
> Do you pull changes from mainline back into your tree(s) on a daily basis?

No.  I'll rebase them once in a while as needed, but I'm not going to
try to stay perpetually up-to-date. The best way to get perpetual
up-to-dateness is to get the drivers iinto a good state and get them
into mainline (which is certainly my goal)

>
> Right now I branched off a 2.6.20 branch and then added my patches (e.g.
> uc0, mb). For each patch I created a new branch. Once I finished adding
> the patches, I consolidated everything into a "Xilinx" branch. I'm
> beginning to wonder if this was a good way to do it. My branches look
> like this now:
>
> * 2.6.20-xlnx
>   b2.6.20
>   b2.6.20-uc0
>   b2.6.20-uc0-mb
>   b2.6.20-uc0-mb-xlnx
>   master
>   origin
>
> Is it common practice to keep individual branches in the repository?

In public trees, no, not really.  In my private tree I've got task
branches galore, but it's probably too confusing to have loads of
branches in a public tree.

>
> I like the way you have the branches separated out for each driver. I
> think I should get them from your tree, merge them with what I have and
> add new driver branches as I add more drivers. This way it would be
> easiest to sync your tree with Xilinx's

As I said, the drivers are already split out by directories; so what I
did is probably unnecessary.  But, yes, feel free to pull my tree into
yours.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
