Message-ID: <00bc01c04b23$92fbfbe0$57c809c0@fel>
Reply-To: "john zhan" <johnzhan@btamail.net.cn>
From: "john zhan" <johnzhan@btamail.net.cn>
To: Íõ³¬·å <chfwang@sina.com.cn>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3A02ECF3.1E072842@iigi.net> <3A072049.C2096C5C@mvista.com> <001b01c04972$7f2e3d10$57c809c0@nt4srv87>
Subject: Re: about ACE860 board
Date: Fri, 10 Nov 2000 22:26:42 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Some older board and its monitor do not support the SIMM which is more than 16MB.

Refer to ACE860 home,I am not sure its still there : www.ace360.com
If you are using ICE/BDM,please check the value of br(x) and or(x) ,(x) is which
CS your SIMM connect to.

For more information,please go to www.fel.com.cn ,
Don't fuck me,
it's none of my business,
 chinese only,:-)

john zhan.

----- Original Message -----
From: Íõ³¬·å <chfwang@sina.com.cn>
To: LinuxPPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, November 08, 2000 6:56 PM
Subject: about ACE860 board


>
> Hi,
>
> Does somebody know the ATLAS ACE860 DARWIN board?
> It's monitor can auto test the 4M/8M DRAM successfully.
> But when I insert a 32M DRAM, the monitor only pass 16M, then test failed.
> I use BDM test it, only can access 16M too.
> Is this the bug of this board?
>
> Best regards,
> Wang Chao Feng
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
