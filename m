To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Whitney, John" <John.Whitney@timesys.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Oops on core dumping
From: Vincent Bernat <bernat@free.fr>
In-Reply-To: <1072840969.730.3.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 31 Dec 2003 14:22:50 +1100")
References: <3D848382FB72E249812901444C6BDB1D1D189F@exchange.timesys.com>
	<1072840969.730.3.camel@gaston>
Date: Fri, 12 Mar 2004 07:55:50 +0100
Message-ID: <m31xnyv9jd.fsf@neo.loria>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OoO En ce  milieu de nuit étoilée du  mercredi 31 décembre 2003,  vers
04:22, Benjamin Herrenschmidt <benh@kernel.crashing.org> disait:

> As you may have seen in my comment, this doesn't work on SMP as
> last_task_used_math isn't used there.

> I suppose we could unconditionally use "current" in this case
> though...

The bug is still here. Is there any problem making you not applying
the correction on your tree ?
--
Document your data layouts.
            - The Elements of Programming Style (Kernighan & Plaugher)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
