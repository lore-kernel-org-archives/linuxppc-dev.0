Date: Sun, 31 Oct 1999 17:22:05 -0600
From: Shaw Terwilliger <sterwill@io.nu>
To: Brad Boyer <flar@marcus.pants.nu>
Cc: Troy Benjegerdes <hozer@drgw.net>, paulus@linuxcare.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PMU daemon
Message-ID: <19991031172205.A26504@io.nu>
References: <381C4668.56DAA6A0@drgw.net> <199911011413.GAA26510@marcus.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199911011413.GAA26510@marcus.pants.nu>; from flar@marcus.pants.nu on Mon, Nov 01, 1999 at 06:13:28AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Boyer wrote:
> Troy Benjegerdes wrote:
> > ncftpget ftp://ftp.linuxcare.com.au/pmud-0.2.tar.gz
> > Remote host has closed the connection.
> > ncftpget: cannot open ftp.linuxcare.com.au: remote host closed control
> > connection. 
> 
> I found that the linuxcare site refuses all connections made with ncftp.
> Other ftp clients seem to work fine.

I'm using ncftp 3.0 BETA (18-21) and can connect and grab files just fine.
In fact I just grabbed pmud.  Maybe it's because the only copy of
pmud I found was in /pub/ppclinux, not in the root directory. 

However, ncftpget is throwing "ncftpget: file retrieval error: PORT failed."

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
