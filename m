Message-ID: <3AC417B4.5F73589@ncal.verio.com>
Date: Thu, 29 Mar 2001 21:20:52 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Franz.Sirl-kernel@lauterbach.com
Cc: linuxppc-dev@lists.linuxppc.org, billfink@capu.net
Subject: Re: xine, ppc and illegal instructions
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
>>At 07:30 27.03.2001, Bill Fink wrote:
>>         *  In configure, there's a case check for"powerpc-*-linux*)".
>>            This should be changed to "powerpc-*-linux* | ppc-*-linux*)".

>This isn't correct, it's always powerpc-*-linux*, the other one is
>superflous. This usually happens if people didn't update their configure
>scripts for a _long_ time and your patch is just papering over that.
>
>Franz.


No, LinuxPPC 2000 Q4 is ppc-*, what version of the
config scripts, I don't know, and don't care. A
lot of packages break because of it, allow both
and save a lot of grief!

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
