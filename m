Date: Sat, 13 Feb 1999 02:12:14 +0100
To: linuxppc-user@lists.linuxppc.org, linux-pmac@samba.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Message-Id: <19990213021214.030720@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've posted the long awaited trackpad tool at:

<ftp://ftp.linuxppc.org/development/users/benh/trackpad_tool.tar.gz>

the syntax is

    trackpad notap|tap|drag|lock

where:

    notap       disable tapping
    tap         enable tapping only
    drag        enable tapping+dragging
    lock        enable drag lock

Note that on my machine, drag and drag lock behave the same, but this is
also true with MacOS.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
