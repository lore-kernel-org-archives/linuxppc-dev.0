To: Tim Woo <thwoo@engmail.uwaterloo.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS mount root problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jul 2001 03:57:44 EDT."
             <3B417AF8.DDC7F300@engmail.uwaterloo.ca>
Date: Tue, 03 Jul 2001 10:13:26 +0200
Message-Id: <20010703081331.2AC6C10E1C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3B417AF8.DDC7F300@engmail.uwaterloo.ca> you wrote:
>
> This is what I have typed, "nfsroot=192.168.0.1:/tftpboot/192.168.0.2"
>
> The following is the message from /var/log/messages
>
> Jul  3 03:57:11 linuxnanpa tftpd[1082]: tftpd: trying to get file:
> /tftpboot/192.168.0.2/zImage
> Jul  3 03:57:17 linuxnanpa dhcpd: BOOTREQUEST from 08:00:3e:2d:35:ab via
> eth0
> Jul  3 03:57:17 linuxnanpa dhcpd: BOOTREPLY for 192.168.0.2 to linuxbrd
> (08:00:3e:2d:35:ab) via eth0
> Jul  3 03:57:23 linuxnanpa mountd[998]: refused mount request from
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> linuxbrd for /tftpboot/linuxbrd (/): no export entry
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> Please help, thanks.

It helps when you just read the error messages.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Hacking's just another word for nothing left to kludge.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
