Message-ID: <3FA50B32.4010400@iti.fi>
Date: Sun, 02 Nov 2003 15:48:34 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage
References: <3FA4F3B2.6050106@iti.fi>
In-Reply-To: <3FA4F3B2.6050106@iti.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kate Alhola wrote:

>
> I just got Motorola5200 lite board and tried complie
> linuxppc_2_4_mpc5200 from
> denx to it.  When i say make bzImage it complains that __res is undefined
>
> __res is pointer to external scc buffer descriptors . Least it looks a
> like that it is
> defined in arch/ppc/platforms/icecube.c but this code looks a like
> complete
> board initialization code so i am not sure is it right module to add
> defining __res

It looks a like that i have too much fixation from mpc8xx(x) programming
in this case bd didnt stand for bufferr descriptor but board u-boot
board descriptor
and in this case the mgt5100_tty.c look a like have one dependence
to ppcboot, it took the ibp bus clock frequency from ppcboot bd struct even
not ppc-boot configuration. I replaced it with just plain #define .
Now just i should do testing ...

Kate

--
+==================================================================+
! Kate Marika Alhola  Internet Technologies International Oy       !
! kate@iti.fi         Phone +358 400 740701 Fax   +358 9 8138715   !
! kate@iki.fi	      http://www.iti.fi    http://www.iki.fi/kate  !
+==================================================================+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
