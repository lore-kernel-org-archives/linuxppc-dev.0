Date: Fri, 2 Jun 2000 12:08:17 -0500 (CDT)
From: Grant Erickson <erick205@tc.umn.edu>
To: Elizabeth Clarke <eclarke@aminocom.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Java
In-Reply-To: <3937F5E7.363DAA1@aminocom.com>
Message-Id: <Pine.SOL.4.20.0006021206220.25717-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Elizabeth,

The problem you cite below is the outcome if you've compiled the
application using the standard GCC PowerPC compiler (native or cross). If
you're using the glibc from MontaVista, you need to use their compiler or
you need to build your own in a manner similar to what they've done.

Regards,

Grant

--
 Grant M. Erickson                    University of Minnesota Alumni
  o mail:erick205@tc.umn.edu                              1996 BSEE
  o http://www.tc.umn.edu/~erick205/                      1998 MSEE

On Fri, 2 Jun 2000, Elizabeth Clarke wrote:
> I'm trying to get jdk118_v2 from linuxppc.org/java to work, but get an
> error loading the shared libraries libc.so.6 with __register_frame_info
> missing.
>
> I'm using glibc1.1.2 from mvista, and defaulting to green_threads. My
> research has thrown up that libraries compiled with gcc and binaries
> compiled with egcs are incompatible. Has anyone else encountered this
> problem, did you resolve it, and how? please.
>
> Thanks,
> Beth


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
