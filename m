Return-Path: <stonepine@126.com>
Received: from m5-142.126.com (m5-142.126.com [202.108.5.142])
	by ozlabs.org (Postfix) with SMTP id B7E0A67C9E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Nov 2006 06:04:15 +1100 (EST)
Message-ID: <45649EF1.1050703@126.com>
Date: Thu, 23 Nov 2006 03:03:13 +0800
From: Stephen Yee <stonepine@126.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: FYI: SM5xx toolchain project berliOS registration
References: <20061120214155.91777352643@atlas.denx.de>
In-Reply-To: <20061120214155.91777352643@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mr. Wolfgang,
   After I ported your linuxppc_2_4_devel.git code to my system and  
used the smi_disp_settings[2]("1024x768-60", 1024, 768, 15385,160, 24, 
29,  3, 136, 6, 0 ) to replace the defualt 'fb.var' settings, the 
Voyager GX PCI Demo Board Ver.A(a PCI cards with  SiliconMotion SM501 
chip) could work perfectly  on PPC 405ep board to support dual  CRT 
monitors with 8bpp, Thanks all of the people in 
linuxppc-embedded@ozlabs.org!  and Thanks the Great code!
   but,There is a small issue that when I used the 16bpp, the color is 
not correct, I thinks it's the notorious  RGB565  issue. I wanna get 
the  messages that the 16bpp have worked correctly on your "TQM5200" 
board?  and if YES, would you please give some advice to me about it?
  
Thanks and Best Regards,
Stephen Yee

Wolfgang Denk wrote:

>In message <4561F9F2.8020706@126.com> you wrote:
>  
>
>>is Here a  successful  story  about using SM501 on PPC platform with
>>this driver?  and would you please give me some advices to drive this
>>devices?
>>    
>>
>
>Not in the context of the 2.6 kernel. But we have a working
>configuration of MPC5200 + SM501 in our 2.4 kernel tree; see the
>"TQM5200" board config at
>http://www.denx.de/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git
>
>Best regards,
>
>Wolfgang Denk
>
>  
>
