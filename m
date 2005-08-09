Return-Path: <wd@denx.de>
To: "Debora Liu" <deboralh@fel.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Aug 2005 13:25:42 +0800."
	<20050809052142.2C53242C5E@denx.de>
Date: Tue, 09 Aug 2005 23:18:30 +0200
Sender: wd@denx.de
Message-Id: <20050809211830.F214D352BD9@atlas.denx.de>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: Volunteers to test i2c-algo-8xx on v2.6? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050809052142.2C53242C5E@denx.de> you wrote:
> 
> I'm working with Wolfgang's ELDK-3.1.1,
> diff against Wolfgang's ELDK-3.1.1 patch is attached.

Ummm... A quick scan showed only reformatting and  style  changes.  I
think  someone who really understands the controller should perform a
review of the code. There are most likely problems hidden - like  the
timeout  of  1  second  which is much too short; we measured nearly 4
seconds (under heavy load) between starting a  transfer  and  getting
the interrupt.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Work 8 hours, sleep 8 hours; but not the same 8 hours.
