Subject: Re: PATCH: requesting feedback on dead function optimisation
To: andrewm@uow.edu.au (Andrew Morton)
Date: Tue, 11 Apr 2000 15:26:14 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.rutgers.edu (Linux kernel mailing list)
In-Reply-To: <38F1B9CB.D23AA3F3@uow.edu.au> from "Andrew Morton" at Apr 10, 2000 09:23:55 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000411052614.654CE3C960@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew Morton writes:
> Graham, do you have any numbers on what this does to the overall build
> size?

By itself, the difference is not enormous. It starts to grow though once you
turn off CONFIG_PROC_FS and CONFIG_SYSCTL, and will make an even bigger
difference when/if I get around to generating a CONFIG_MESSAGES patch to allow
you to turn off all kernel messages. This eliminates all the human-readable
strings from the kernel, for use in deeply embedded systems. I've seen savings
of around 150-200K for hacks I've done so far, but it's hard to give a final
estimate yet.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
