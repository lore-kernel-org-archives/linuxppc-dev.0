Message-ID: <3D810AF2.2034238C@koffie.nl>
Date: Thu, 12 Sep 2002 23:45:22 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
References: <3D80F2F7.3FB3AE4B@koffie.nl> <20020912095217.449@192.168.4.1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> Hrm... you should check the various CPU erratas, I think
> the perf. counter exception suffers from the same bugs
> the thermal exceptions has regarding clashing with DEC
> and thus losing exception context information on some
> G4s. If this is the case, that would basically prevent
> using it.

Ooh, that sounds bad!  Thanks for the hint.


Segher

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
