Message-ID: <39EC7031.A17F4366@mvista.com>
Date: Tue, 17 Oct 2000 11:28:49 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
CC: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: If not CONFIG_ALL_PPC, you're broken
References: <39EB8A67.E2F9C023@mvista.com> <39EBDC43.3F7E57B8@mvista.com> <20001017041751.A9882@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> My solution for creating a slim embedded PPC kernel in 2.2 was to
> stub out all the calls to Mac/CHRP specific routines that were made
> in head.S and setup.c.

I think that is fine, but we have lost the configuration options that
indicate this should happen.  I first want to get a set of options
that makes sense, rework the code so we can selectively build the
kernels again (with CONFIG_ALL_PPC a sum of the options), and be able
to select processor core/processor type separately (i.e. I need to
select CONFIG_6xx and CONFIG_8260 at the same time...there are more
of these coming from both Mot and IBM).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
