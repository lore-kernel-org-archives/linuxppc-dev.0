Date: Fri, 7 Mar 2003 11:35:31 -0600
From: Nathan Ingersoll <ningerso@ruralcenter.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-ID: <20030307173531.GA6052@ruralcenter.org>
References: <20030307164753.GA5240@ruralcenter.org> <3E68D5BF.1050906@embeddededge.com>
Mime-Version: 1.0
In-Reply-To: <3E68D5BF.1050906@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 07, 2003 at 12:24:15PM -0500, Dan Malek wrote:
>
> For some time now the Linux kernel has provided support for emulating
> the 'mfspr rd, PVR' instruction in user space.  Do this once, get the
> PVR and determine the processor type.
>
> You can also just read /proc/cpuinfo and search for the 'cpu :' line.
> It will indicate the processor type and if altivec is supported.
>
> There are probably other ways as well....

Thanks for the info Dan, I'll check into doing it this way. I am still
curious about some of my other questions, such as recovering from a
SIGILL caused by an actual illegal instruction. Anyone willing to chime
in on that?

--
------------------------------------------------------------------------
| Nathan Ingersoll           \\ Computer Systems & Network Coordinator |
| ningerso@ruralcenter.org    \\ http://www.ruralcenter.org            |
| http://ningerso.atmos.org/   \\ Minnesota Center for Rural Health    |
------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
