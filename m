Message-ID: <385008EF.AF52D23E@babcockbrown.com>
Date: Thu, 09 Dec 1999 11:54:23 -0800
From: Hugh Caley <hughc@babcockbrown.com>
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Mozilla preM12 ppc rpms...
References: <Pine.LNX.4.10.9912090723100.23296-100000@shell.unixbox.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you for doing this; I have the following problems.  Please let me know
what other information I can give you that would help.

Attempting to install the rpms gives me:

[root@sf-hughc local]# rpm -ivh moz*.rpm
error: failed dependencies:
        libgtkmozilla.so.0 is needed by mozilla-5.0-M11

Trying to run the binary from the tar file gives me:

[root@sf-hughc package]# ./mozilla
.//run-mozilla.sh ./mozilla-bin
MOZILLA_FIVE_HOME=/usr/local/package
  LD_LIBRARY_PATH=/usr/local/package
       SHLIB_PATH=/usr/local/package
          LIBPATH=/usr/local/package
      MOZ_PROGRAM=./mozilla-bin
      MOZ_TOOLKIT=
        moz_debug=0
     moz_debugger=
nNCL: registering deferred (0)
CSSLoaderImpl::LoadSheet: Load of URL 'resource:///chrome/xul.css' failed.
Error code: 16389
Error: Can't load:
resource:///chrome/profile/content/default/createProfileWizard.xul (80004005)

at which point it hangs.

Hugh

Ani Joshi wrote:

> I have placed a preM12 snapshot at
>
> ftp://devel.linuxppc.org/users/ajoshi/{RPMS,SRPMS}
>
> This build includes Franz Sirl's XPTCall port.
> Please let me know how it well it fares for everyone as we have not
> tested it much.
>
> a tarball can also be found in /users/ajoshi
>
> Thank you,
>
> ani

--
Hugh Caley, Unix System Administrator
Babcock & Brown, San Francisco
415-512-1515 hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
