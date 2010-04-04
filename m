Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id A2A54B7C09
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Apr 2010 17:27:48 +1000 (EST)
Received: by ywh34 with SMTP id 34so2160718ywh.17
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Apr 2010 00:27:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <h2nc3d0340b1004040010ga00f75b6k38eccbe66ce11799@mail.gmail.com>
References: <h2nc3d0340b1004040010ga00f75b6k38eccbe66ce11799@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 4 Apr 2010 01:27:27 -0600
Message-ID: <y2ufa686aa41004040027p560c1b8bw6cdf3f096398cd42@mail.gmail.com>
Subject: Re: Migrating from ppc to powerpc
To: Shawn Jin <shawnxjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 4, 2010 at 1:10 AM, Shawn Jin <shawnxjin@gmail.com> wrote:
> Hi,
>
> I have a project that needs port ppc drivers to the powerpc arch. I've been
> searching the mailing list for some clues on what tasks they would look like
> and where should be the starting point. It's been quite a while since the
> powerpc arch started so the info is huge. The searching doesn't seem to be
> easy task for itself. :(
>
> Would gurus here shed some light? One thing I know of is a device tree.
> Assuming a device tree is provided, how much work would it be for driver
> porting?

What processor/board/soc are you using?  The easiest path is to start
with a similar board and adapt the device tree source file (.dts in
arch/powerpc/boot/dts) to match your board with your devices.  You'll
need to add a node to the tree for each device you add.  If you post
your new .dts file to devicetree-discuss@lists.ozlabs.org for review,
then I and others will help you to craft it and get it into the format
that it needs to be in.

Porting device drivers is relatively straight forward.  At the moment
you need to change your platform_drivers into of_platform_drivers.
Search the drivers/ tree for of_platform_driver to see lots of
examples of what these should look like.

Cheers,
g.
