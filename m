To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Rakesh Jagota <j.rakesh@gdatech.co.in>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 May 2003 08:31:05 CDT."
             <Pine.LNX.4.44.0305150828210.26702-100000@spider.ancor.com>
Date: Thu, 15 May 2003 15:35:01 +0200
Message-Id: <20030515133506.57E40C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.44.0305150828210.26702-100000@spider.ancor.com> you wrote:
>
> Don't know why you want to handle it from user space, but the easiest way
> to notify an application would be to send a signal. Have a special ioctl()
> to notify the driver that this application wants a signal, and then when
> the driver receives the interrupt it clears the condition and sends a
> signal to the registered application(s).

Instead of inventing new special ioctl()'s it's  probably  better  to
use existing and standardized interfaces like select() resp. poll().

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The POP3 server service depends on the SMTP  server  service,  which
failed to start because of the following error: The operation comple-
ted successfully."                         -- Windows NT Server v3.51

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
