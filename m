Date: Thu, 3 Feb 2000 02:10:29 -0800 (PST)
From: Patrik Jonsson <patrik@ucolick.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: lidstdc++ string problems
In-Reply-To: <38993D7F.B0964A77@dalim.de>
Message-ID: <Pine.GSO.4.03.10002030203260.27105-100000@isis.ucolick.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone,

I wonder if there is a known problem with the c++ string class? (I just
upgraded to gcc 2.95.2, but it didn't help.) What happens is that I read
into a string from a char* using a strstream as " strstream >> string".
This works on other machines, but on linuxppc the resulting string
contains junk at the end that is in another string object defined earlier.
It's like it doesn't properly define what the length is. If I look at it
in gdb, the "dat" field contains the right char*, but when reading it more
stuff appears at the end. It's HIGHLY annoying, it's plain impossible to
make anything work! Is this known / is there a fix or something? It seems
bad if we can't trust the standard library... :(

Any hints would be much appreciated,

	/Patrik


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
