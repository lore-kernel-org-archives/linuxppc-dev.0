Date: Fri, 13 Aug 1999 10:09:29 -0400
From: Mike Lambert <lambert@jeol.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Extra brightness off with the XClaim 3D Plus
In-Reply-To: <37B1D5F5.F76809E9@liberate.com>
Message-ID: <Pine.SGI.4.10.9908130946190.968-100000@davinci.jeol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Aug 1999, Rick Meier wrote:

> On the XClaim 3D plus the extra brightness needs to be turned off or the
> card overdrives the monitor.  Here is a patch to the kernel if anyone
> wants to try it.

> --- atyfb.c     Wed Aug 11 13:49:29 1999
> +++ atyfb.c.orig        Wed Aug 11 13:57:49 1999
> @@ -3418,7 +3418,7 @@
>      if (Gx == GT_CHIP_ID || Gx == GU_CHIP_ID || Gx == GV_CHIP_ID ||
>         Gx == GW_CHIP_ID || Gx == GZ_CHIP_ID || Gx == LG_CHIP_ID ||
>         Gx == GB_CHIP_ID || Gx == GD_CHIP_ID || Gx == GI_CHIP_ID ||
> +       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
>         i |= 0x2;       /*DAC_CNTL|0x2 turns off the extra brightness
> for gt*/
>      aty_st_8(DAC_CNTL, i, info);
>      aty_st_8(DAC_MASK, 0xff, info);

Thanks Rick, this works as advertised. The XClaim 3D Plus in my B+W G3 400
now works properly. Well, except for the mild snow down the left side of
the display, but that is a different problem...

-mike

-- 
Michael Lambert             JEOL USA Inc.
Systems Administration      http://www.jeol.com/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
