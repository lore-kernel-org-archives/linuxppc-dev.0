In-Reply-To: <4019681F012FDFDC@mta1.wss.scd.yahoo.com> (added by postmaster@mail.san.yahoo.com)
References: <4019681F012FDFDC@mta1.wss.scd.yahoo.com> (added by postmaster@mail.san.yahoo.com)
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1416963E-6C06-11D8-95BB-000393DBC2E8@motorola.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: Jumbo Frames and MPC8540
Date: Mon, 1 Mar 2004 22:57:17 -0600
To: "Phil Shepard" <phil@artismicro.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Phil,

I believe with the latest driver you can set the mtu to 8192 and get
jumbo frame support for the 8540.  (ifconfig will allow you to set the
mtu)

- kumar

On Feb 29, 2004, at 10:56 AM, Phil Shepard wrote:

>
> Hi,
>
>    I'm working with a MPC8540 trying to measure the performance of the
> built
> in GigE.  I'm running 2.4.25 on the PPC.  On the other end is a Dell
> Precision M60 laptop with it's Broadcom 5705 GigE Chip I'm running RH9
> and
> can't seem to get the MTU much larger than 1500.  I'd like to simply
> transfer 8192 byte jumbo frames from the Dell to the MPC8540 running
> an echo
> server.
>
> Any suggestions?  Is there a better list for this type of question?
>
> Phil
> ---------------------------------------
> Phil Shepard
> Applications Engineer
> Artis Microsystems
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
