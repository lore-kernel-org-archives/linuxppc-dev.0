Subject: Re: Oops on core dumping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent Bernat <bernat@free.fr>
Cc: "Whitney, John" <John.Whitney@timesys.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <m31xnyv9jd.fsf@neo.loria>
References: <3D848382FB72E249812901444C6BDB1D1D189F@exchange.timesys.com>
	 <1072840969.730.3.camel@gaston>  <m31xnyv9jd.fsf@neo.loria>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1079074747.9739.335.camel@gaston>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 17:59:07 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-03-12 at 17:55, Vincent Bernat wrote:
> OoO En ce  milieu de nuit étoilée du  mercredi 31 décembre 2003,  vers
> 04:22, Benjamin Herrenschmidt <benh@kernel.crashing.org> disait:
>
> > As you may have seen in my comment, this doesn't work on SMP as
> > last_task_used_math isn't used there.
>
> > I suppose we could unconditionally use "current" in this case
> > though...
>
> The bug is still here. Is there any problem making you not applying
> the correction on your tree ?

Didn't find the time to dive into it, do you have a patch ready
to apply ? :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
