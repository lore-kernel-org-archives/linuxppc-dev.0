Date: Tue, 12 Oct 1999 00:23:37 -0700 (PDT)
From: Patrik Jonsson <patrik@ucolick.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Bizarre g++ problem
In-Reply-To: <3802DE1E.37E49762@chpc.utah.edu>
Message-ID: <Pine.GSO.4.03.9910120015540.5402-100000@isis.ucolick.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey everyone,
I'm having a very weird problem with my code:

cout << xs << '\n';  //(xs is an int class member)
double e2=xs;
cout << e2 << '\n';

produces:
 200
 -4.5036e+15

as output. What the @#$@# is going on?

	/Patrik


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
