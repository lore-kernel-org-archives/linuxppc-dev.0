Message-Id: <5.0.2.1.2.20010327153842.00ad0768@mail.munich.netsurf.de>
Date: Tue, 27 Mar 2001 15:41:40 +0200
To: Bill Fink <billfink@capu.net>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: xine, ppc and illegal instructions
Cc: linuxppc-dev@lists.linuxppc.org, billfink@capu.net
In-Reply-To: <Pine.LNX.4.21.0103262330001.19578-100000@gwiz.nasa.atd.net
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 07:30 27.03.2001, Bill Fink wrote:
>         *  In configure, there's a case check for "powerpc-*-linux*)".
>            This should be changed to "powerpc-*-linux* | ppc-*-linux*)".

This isn't correct, it's always powerpc-*-linux*, the other one is
superflous. This usually happens if people didn't update their configure
scripts for a _long_ time and your patch is just papering over that.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
