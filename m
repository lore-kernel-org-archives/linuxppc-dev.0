From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Masik <masik@pc203b.fzu.cz>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: hdparm and disc errors
Date: Fri, 21 Sep 2001 16:22:18 +0200
Message-Id: <20010921142218.5696@smtp.adsl.oleane.com>
In-Reply-To: <4vr8t0veui.fsf@darbujan.fzu.cz>
References: <4vr8t0veui.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Do you think it is a real disc failure or is anything wrong with the
>hdparm setting? Is the unmasking dangerous for Pismo?

That's weird. Note that there are chances that 2.2 lockup on such IDE errors.

The driver did evolve slightly, but not in a way that explains your problem.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
