Date: Sat, 2 Jan 1999 13:51:45 -0800
From: Sean Harding <sharding@gutenberg.uoregon.edu>
Reply-To: Sean Harding <sharding@oregon.uoregon.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Keyboard repeat problem
Message-ID: <Pine.SGI.4.02.9901021348340.23664-100000@gutenberg.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There's some strangeness in the adb code in the 2.2-pre2 kernel. My
roommate reports seeing it in the newer vger kernels also. Every so often
(I only get it a couple of times a day), when I type a letter, it will
show up three times or so. I haven't been able to reliably duplicate it,
but it has happened enough times that I'm sure it's not something I'm
imagining. It doesn't appear to be related to the regular key-repeat
function (the dleay for that is pretty long, and I'm not holding they keys
down for any length of time at all).

Any ideas?

sean

-- 
Sean Harding sharding@oregon.uoregon.edu|"art may imitate life
http://gladstone.uoregon.edu/~sharding/ | but life imitates t.v."
Consulting: http://www.efn.org/~seanh/  | --ani difranco


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
