From: phandel@cise.ufl.edu
Date: Sun, 5 Dec 1999 21:25:51 -0500 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Problem with NFS / rpc.mountd:
Message-ID: <Pine.LNX.4.10.9912052125250.1076-100000@PetesBox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to make rpc.mountd allow insecure ports (with rpc.mountd -n)
but apparently this feature hasn't been added to the new kernel version of
nfs yet?

(127) PetesBox 5:53am ~> rpc.mountd -n
Usage: rpc.mountd [-Fhnpv] [-d kind] [-f exports-file] [-V version]
        [-N version] [--debug kind] [--help] [--version]
        [--exports-file=file] [--nfs-version version]
        [--no-nfs-version version]
(128) PetesBox 6:01am ~> rpc.mountd --version
kmountd 1.3 (0.4.22)
(129) PetesBox 6:03am ~> uname -a
Linux PetesBox 2.2.13 #13 Sun Dec 5 01:19:30 EST 1999 ppc unknown

My new old freebsd 2.2.8 nfs can only use insecure ports afaict and works
fine with a friend of mine's redhat 4.x machine when he adds -n to his
rpc.mountd.


Thanks,
Peter

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
